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
exports.SpotifyService = void 0;
const runApplescript = require("run-applescript");
class SpotifyService {
    constructor() {
        this.lastTrack = undefined;
    }
    getTrackID() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield runApplescript('tell application "Spotify" to id of current track as string');
        });
    }
    getArtistName() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield runApplescript('tell application "Spotify" to artist of current track as string');
        });
    }
    getTrackName() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield runApplescript('tell application "Spotify" to name of current track as string');
        });
    }
    getCurrentlyPlaying() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const [title, artist, id] = yield Promise.all([
                    this.getTrackName(),
                    this.getArtistName(),
                    this.getTrackID()
                ]);
                // log.info(
                //   JSON.stringify({
                //     title,
                //     artist,
                //     id
                //   })
                // );
                return {
                    title,
                    artist,
                    id
                };
            }
            catch (err) {
                console.log({ err });
                return undefined;
            }
        });
    }
    getFormattedTrack() {
        if (!this.lastTrack) {
            throw new Error('Could not fetch track');
        }
        const { title, artist } = this.lastTrack;
        return `${title} - ${artist}`;
    }
    isNewTrackPlaying({ id, title, artist }) {
        if (!this.lastTrack) {
            return true;
        }
        return (id !== this.lastTrack.id || title !== this.lastTrack.title || artist !== this.lastTrack.artist);
    }
    setLastTrack(track) {
        this.lastTrack = track;
    }
    getLastTrack() {
        return this.lastTrack;
    }
}
exports.SpotifyService = SpotifyService;
//# sourceMappingURL=SpotifyService.js.map