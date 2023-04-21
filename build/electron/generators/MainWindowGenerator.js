"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MainWindowGenerator = void 0;
const electron_1 = require("electron");
const path = require("path");
const fs = require("fs");
const https_1 = require("https");
const package_json_1 = require("../../package.json");
class MainWindowGenerator {
    constructor(playerController) {
        /**
         * Set up the BrowserWindow and apply all event listeners/handlers
         * The playerController should handle all business logic here
         */
        this.createMainWindow = () => {
            const mainWindow = new electron_1.BrowserWindow({
                backgroundColor: 'transparent',
                width: 500,
                height: 300,
                webPreferences: {
                    devTools: true,
                    nodeIntegration: true,
                    contextIsolation: false,
                    backgroundThrottling: false,
                    javascript: true,
                    preload: path.join(__dirname, '../preload.js')
                },
                frame: false,
                fullscreenable: false,
                resizable: false,
                show: true, //! isDev
            });
            /**
             * Create auth web server to intercept OAuth code
             * Once completed, exchange for access token and close server
             */
            const key = fs.readFileSync(path.join(__dirname, '../../key.pem')).toString();
            const cert = fs.readFileSync(path.join(__dirname, '../../cert.pem')).toString();
            const rootCA = fs.readFileSync(path.join(__dirname, '../../rootCA.pem')).toString();
            const authServer = (0, https_1.createServer)({ key, cert }, (req, res) => __awaiter(this, void 0, void 0, function* () {
                console.log(req.url);
                const isAuthorized = yield this.handleAuthRedirect(req.url);
                console.log(isAuthorized);
                if (isAuthorized) {
                    this.sendMessage(mainWindow, {
                        type: 'AUTH',
                        body: this.playerController.isUserAuthenticated()
                    });
                    this.sendMessage(mainWindow, {
                        type: 'USER_DATA',
                        body: this.playerController.getUserData()
                    });
                    this.loadApp(mainWindow);
                }
            }));
            authServer.listen(7734);
            this.loadApp(mainWindow);
            // Hot Reloading
            if (true) { //! isDev
                require('electron-reload')(__dirname, {
                    electron: path.join(__dirname, '..', '..', 'node_modules', '.bin', 'electron'),
                    forceHardReset: true,
                    hardResetMethod: 'exit'
                });
            }
            electron_1.ipcMain.on('message-to-main', (event, { type }) => {
                this.generateIpcMessageHandlers(mainWindow, type);
            });
            setInterval(() => __awaiter(this, void 0, void 0, function* () {
                if (this.playerController.isUserAuthenticated() &&
                    !this.playerController.isPlayerUpdating()) {
                    const wasUpdated = yield this.playerController.updateIfNewTrack();
                    if (wasUpdated) {
                        this.sendMessage(mainWindow, {
                            type: 'CURRENTLY_PLAYING',
                            body: this.playerController.getCurrentlyPlayingTrack()
                        });
                    }
                }
            }), 3000);
            return mainWindow;
        };
        this.playerController = playerController;
    }
    loadApp(mainWindow) {
        if (true) { //! isDev
            mainWindow.loadURL('http://127.0.0.1:3000/index.html');
            mainWindow.webContents.openDevTools({ mode: 'detach' });
        }
        else {
        }
    }
    handleAuthRedirect(url) {
        return __awaiter(this, void 0, void 0, function* () {
            let isAuthorized = false;
            console.log(url);
            if (url.includes('state')) {
                console.log('YOUR CODE: ' + url.substring(7, url.length - 7));
                yield this.playerController.exchangeUserCodeForAccessToken(url.substring(7, url.length - 7));
                yield this.playerController.fetchUserData();
                isAuthorized = true;
            }
            // const parsedQueryString = qs.parseUrl(url);
            // const { code } = parsedQueryString.query;
            // if (code && Object.keys(parsedQueryString.query).includes('state')) {
            //   await this.playerController.exchangeUserCodeForAccessToken(code as string);
            //   await this.playerController.fetchUserData();
            //   isAuthorized = true;
            // }
            return isAuthorized;
        });
    }
    sendMessage(mainWindow, message) {
        mainWindow.webContents.send('message-from-main', message);
    }
    generateIpcMessageHandlers(mainWindow, type) {
        return __awaiter(this, void 0, void 0, function* () {
            switch (type) {
                case 'AUTH':
                    this.sendMessage(mainWindow, {
                        type: 'AUTH',
                        body: this.playerController.isUserAuthenticated()
                    });
                    break;
                case 'LOGOUT':
                    this.sendMessage(mainWindow, {
                        type: 'LOGOUT',
                        body: this.playerController.logOut()
                    });
                    break;
                case 'CURRENTLY_PLAYING':
                    this.sendMessage(mainWindow, {
                        type: 'CURRENTLY_PLAYING',
                        body: this.playerController.getCurrentlyPlayingTrack()
                    });
                    break;
                case 'PLAYER_PREFERENCES':
                    this.sendMessage(mainWindow, {
                        type: 'PLAYER_PREFERENCES',
                        body: this.playerController.getPlayerPreferences()
                    });
                    break;
                case 'TOGGLE_INCOGNITO':
                    const playerPreferences = this.playerController.getPlayerPreferences();
                    this.playerController.setPlayerPreference('isIncognito', !playerPreferences.isIncognito);
                    if (this.playerController.getPlayerPreferences().isIncognito) {
                        yield this.playerController.unsetStatus();
                    }
                    this.sendMessage(mainWindow, {
                        type: 'PLAYER_PREFERENCES',
                        body: this.playerController.getPlayerPreferences()
                    });
                    break;
                case 'USER_DATA':
                    const userData = this.playerController.getUserData();
                    if (userData) {
                        this.sendMessage(mainWindow, {
                            type: 'USER_DATA',
                            body: userData
                        });
                    }
                    break;
                case 'APP_VERSION':
                    this.sendMessage(mainWindow, {
                        type: 'APP_VERSION',
                        body: package_json_1.version
                    });
                    break;
                case 'RESTART_APP':
                    break;
                default:
                    break;
            }
        });
    }
}
exports.MainWindowGenerator = MainWindowGenerator;
//# sourceMappingURL=MainWindowGenerator.js.map