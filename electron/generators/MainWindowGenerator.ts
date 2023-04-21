import { BrowserWindow, ipcMain } from 'electron';
import * as path from 'path';
import * as fs from 'fs';
import { createServer } from 'https';

import { PlayerController } from '../controllers/PlayerController';
import { Message, MessageType } from '../types';
import { version } from '../../package.json';

export class MainWindowGenerator {
  playerController: PlayerController;

  constructor(playerController: PlayerController) {
    this.playerController = playerController;
  }

  /**
   * Set up the BrowserWindow and apply all event listeners/handlers
   * The playerController should handle all business logic here
   */
  createMainWindow = (): BrowserWindow => {
    const mainWindow = new BrowserWindow({
      backgroundColor: 'transparent',
      width: 500,
      height: 300,
      webPreferences: {
        devTools: true,//! isDev
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
    const authServer = createServer({ key, cert }, async (req, res) => {
      console.log(req.url);
      const isAuthorized = await this.handleAuthRedirect(req.url as string);
      console.log(isAuthorized)
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
    });

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

    ipcMain.on('message-to-main', (event: Electron.IpcMainEvent, { type }: Message) => {
      this.generateIpcMessageHandlers(mainWindow, type);
    });

    setInterval(async () => {
      if (
        this.playerController.isUserAuthenticated() &&
        !this.playerController.isPlayerUpdating()
      ) {
        const wasUpdated = await this.playerController.updateIfNewTrack();

        if (wasUpdated) {
          this.sendMessage(mainWindow, {
            type: 'CURRENTLY_PLAYING',
            body: this.playerController.getCurrentlyPlayingTrack()
          });
        }
      }
    }, 3000);

    return mainWindow;
  };

  private loadApp(mainWindow: BrowserWindow) {
    if (true) { //! isDev
      mainWindow.loadURL('http://127.0.0.1:3000/index.html');
      mainWindow.webContents.openDevTools({ mode: 'detach' });
    } else {
    }
  }

  private async handleAuthRedirect(url: string): Promise<boolean> {
    let isAuthorized = false;
    console.log(url);
    if (url.includes('state')) {
      console.log('YOUR CODE: ' + url.substring(7, url.length - 7))
      await this.playerController.exchangeUserCodeForAccessToken(url.substring(7, url.length - 7));
      await this.playerController.fetchUserData();

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
  }

  private sendMessage(mainWindow: BrowserWindow, message: Message) {
    mainWindow.webContents.send('message-from-main', message);
  }

  private async generateIpcMessageHandlers(mainWindow: BrowserWindow, type: MessageType) {
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
          await this.playerController.unsetStatus();
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
          body: version
        });
        break;

      case 'RESTART_APP':
        break;

      default:
        break;
    }
  }
}
