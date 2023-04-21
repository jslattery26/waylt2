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
exports.AuthService = void 0;
/**
 * In order to not store client secret on the Electron app,
 * we call an external auth API which will exchange the code for an access token
 */
class AuthService {
    getAuthData(code) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log('what the fuck');
            try {
                const body = {
                    'client_id': '340624728833.3331468548978',
                    'client_secret': 'eaf91bf199f69dc825b74272c1f12506',
                    'code': code,
                };
                const response = yield fetch('https://slack.com/api/oauth.access', { method: 'POST', body: JSON.stringify(body), });
                const data = yield response.json();
                console.log(data);
                return data;
            }
            catch (e) {
                console.log("FAGGOT!");
                console.log(e);
                return e;
            }
        });
    }
}
exports.AuthService = AuthService;
//# sourceMappingURL=AuthService.js.map