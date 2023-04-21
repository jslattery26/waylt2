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
exports.SlackService = void 0;
const axios_1 = require("axios");
class SlackService {
    constructor(authService) {
        this.slackAccessToken = undefined;
        this.userData = undefined;
        this.authService = authService;
    }
    exchangeCodeForAccessToken(code) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const { userId, teamId, accessToken } = yield this.authService.getAuthData(code);
                if (!accessToken) {
                    throw new Error('Unable to authorize user');
                }
                this.setAccessToken(accessToken);
                this.userData = { userId, teamId };
                return {
                    slackAccessToken: accessToken,
                    userData: {
                        userId,
                        teamId
                    }
                };
            }
            catch (err) {
                console.log(err);
            }
        });
    }
    setAccessToken(accessToken) {
        this.slackAccessToken = accessToken;
    }
    fetchUserData() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield axios_1.default.get(`https://slack.com/api/users.profile.get`, {
                    headers: { Authorization: `Bearer ${this.slackAccessToken}` }
                });
                if (!res.data.ok) {
                    throw new Error(JSON.stringify(res.data));
                }
                const { real_name, image_72 } = res.data.profile;
                if (this.userData) {
                    this.userData.userName = real_name;
                    this.userData.userAvatar = image_72;
                    return this.userData;
                }
            }
            catch (err) {
                console.log(err);
            }
        });
    }
    fetchTeamData() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield axios_1.default.get(`https://slack.com/api/team.info`, {
                    headers: { Authorization: `Bearer ${this.slackAccessToken}` }
                });
                if (!res.data.ok) {
                    throw new Error(JSON.stringify(res.data));
                }
                const { name } = res.data.team;
                if (this.userData) {
                    this.userData.teamName = name;
                }
                return this.userData;
            }
            catch (err) {
                console.log(err);
            }
        });
    }
    postStatus(message) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield axios_1.default.post(`https://slack.com/api/users.profile.set`, {
                    profile: {
                        status_text: message,
                        status_emoji: ':musical_note:',
                        status_expiration: 0
                    }
                }, {
                    headers: { Authorization: `Bearer ${this.slackAccessToken}` }
                });
                if (!res.data.ok) {
                    throw new Error(JSON.stringify(res.data));
                }
            }
            catch (err) {
                console.log(err);
            }
        });
    }
    unsetStatus() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield axios_1.default.post(`https://slack.com/api/users.profile.set`, {
                    profile: {
                        status_text: '',
                        status_emoji: ''
                    }
                }, {
                    headers: { Authorization: `Bearer ${this.slackAccessToken}` }
                });
                if (!res.data.ok) {
                    throw new Error(JSON.stringify(res.data));
                }
            }
            catch (err) {
                console.log(err);
            }
        });
    }
}
exports.SlackService = SlackService;
//# sourceMappingURL=SlackService.js.map