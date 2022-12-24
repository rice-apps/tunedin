import SpotifyWebApi from 'spotify-web-api-node';
import Router from '@koa/router';

var spotifyApi = new SpotifyWebApi({
	// clientId: //BLOCKING ON DOTENV,
	// clientSecret: //BLOCKING ON DOTENV,
	// redirectUri: //BLOCKING ON DOTENV,
	// clientId: '6d5af6a94aa241dd89626407ab9fc2fc',
	// clientSecret: '9b09ad81ded14600bba84d6c9131f7ff',
	// redirectUri: 'http://localhost:3000/callback',
});

const scopes = [
	'ugc-image-upload',
	'user-read-playback-state',
	'user-modify-playback-state',
	'user-read-currently-playing',
	'streaming',
	'app-remote-control',
	'user-read-email',
	'user-read-private',
	'playlist-read-collaborative',
	'playlist-modify-public',
	'playlist-read-private',
	'playlist-modify-private',
	'user-library-modify',
	'user-library-read',
	'user-top-read',
	'user-read-playback-position',
	'user-read-recently-played',
	'user-follow-read',
	'user-follow-modify',
];

const router = new Router({
	prefix: '/spotify',
});

router.get('/login', async (ctx, next) => {
	ctx.redirect(spotifyApi.createAuthorizeURL(scopes));
});

router.get('/callback', async (ctx, next) => {
	const error = ctx.query.error;
	const code = ctx.query.code;
	const state = ctx.query.state;

	if (error) {
		console.error('Callback Error:', error);
		ctx.body = `Callback Error: ${error}`;
		return;
	}
	const authData = await spotifyApi
		.authorizationCodeGrant(code)
		.catch((error) => {
			console.error('Error getting Auth Tokens:', error);
			ctx.body = `Error getting Auth Tokens: ${error}`;
			return;
		});

	const access_token = authData.body['access_token'];
	const refresh_token = authData.body['refresh_token'];
	const expires_in = authData.body['expires_in'];

	console.log('Access Token:', access_token);
	console.log('Refresh Token:', refresh_token);
	console.log(
		`Sucessfully retreived access token. Expires in ${expires_in} s.`
	);

	ctx.body = 'Success! You can now close the window.';

	//Refresh the access token before it expires
	setInterval(async () => {
		const data = await spotifyApi.refreshAccessToken();
		const access_token = data.body['access_token'];

		spotifyApi.setAccessToken(access_token);
	}, (expires_in / 2) * 1000);
});

export default router;
