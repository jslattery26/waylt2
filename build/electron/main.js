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
const electron_1 = require("electron");
const ElectronStore = require("electron-store");
const services_1 = require("./services/");
const generators_1 = require("./generators");
const controllers_1 = require("./controllers");
let mainWindow;
let tray;
// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
electron_1.app.on('ready', () => __awaiter(void 0, void 0, void 0, function* () {
    const store = new ElectronStore();
    if (true) { //! isDev
        store.clear();
    }
    const spotifyService = new services_1.SpotifyService();
    const authService = new services_1.AuthService();
    const slackService = new services_1.SlackService(authService);
    const playerController = new controllers_1.PlayerController(spotifyService, slackService, store);
    playerController.hydrateAccessToken();
    const mainWindowGenerator = new generators_1.MainWindowGenerator(playerController);
    mainWindow = mainWindowGenerator.createMainWindow();
    const trayGenerator = new generators_1.TrayGenerator(mainWindow);
    tray = trayGenerator.createTray();
    electron_1.app.dock.hide();
}));
// SSL/TSL: this is the self signed certificate support
electron_1.app.on('certificate-error', (event, webContents, url, error, certificate, callback) => {
    // On certificate error we disable default behaviour (stop loading the page)
    // and we then say "it is all fine - true" to the callback
    event.preventDefault();
    callback(true);
});
// Quit when all windows are closed, except on macOS. There, it's common
// for applications and their menu bar to stay active until the user quits
// explicitly with Cmd + Q.
electron_1.app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        electron_1.app.quit();
    }
});
// In this file you can include the rest of your app"s specific main process
// code. You can also put them in separate files and require them here.
//# sourceMappingURL=main.js.map