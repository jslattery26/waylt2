import { SlackUserData } from '../types';


/**
 * In order to not store client secret on the Electron app,
 * we call an external auth API which will exchange the code for an access token
 */
export class AuthService {
  async getAuthData(code: string): Promise<SlackUserData & { accessToken: string } | any> {

    console.log('what the fuck');
    try {

      const body = {
        'client_id': '340624728833.3331468548978',
        'client_secret': 'eaf91bf199f69dc825b74272c1f12506',
        'code': code,
      };
      const response = await fetch('https://slack.com/api/oauth.access', { method: 'POST', body: JSON.stringify(body), });
      const data = await response.json();
      console.log(data);
      return data;
    } catch (e) {
      console.log("FAGGOT!");
      console.log(e);
      return e;
    }

  }
}
