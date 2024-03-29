import SpotifyWebApi from 'spotify-web-api-node';
import Router from '@koa/router';
import { CLIENT_ID, CLIENT_SECRET, REDIRECT_URI } from '../config';

var spotifyApi = new SpotifyWebApi({
	clientId: CLIENT_ID,
	clientSecret: CLIENT_SECRET,
	redirectUri: REDIRECT_URI,
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
	ctx.body = {
		//Retrieves the login url and send to front-end.
		url: spotifyApi.createAuthorizeURL(scopes),
	};
});

router.get('/callback', async (ctx, next) => {
	const error = ctx.query.error;
	const code = ctx.query.code;

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

	spotifyApi.setAccessToken(access_token);
	spotifyApi.setRefreshToken(refresh_token);

	console.log('Access Token:', access_token);
	console.log('Refresh Token:', refresh_token);
	console.log(
		`Sucessfully retreived access token. Expires in ${expires_in} s.`
	);

	ctx.body = 'Success! You can now close the window.';

	// Refresh the access token before it expires.
	setInterval(async () => {
		const data = await spotifyApi.refreshAccessToken();
		const access_token = data.body['access_token'];

		spotifyApi.setAccessToken(access_token);
	}, (expires_in / 2) * 1000);
});

// Add a route for searching for a track on Spotify API.
router.get('/search/:query', async (ctx, next) => {
	const query = ctx.params.query;
	var queryResult;
	try {
		queryResult = await spotifyApi.searchTracks(query);
	} catch (error) {
		console.log(`Received the following error from query: \n ${error}`);
		ctx.body = `Receive the following error from query: ${error}`;
		return;
	}
	const firstPage = queryResult?.body?.tracks?.items;

	if (firstPage === undefined) {
		ctx.body = [];
		return;
	}

	const parsedPage = firstPage.map(({ id, name }) => ({ id, name }));

	ctx.body = parsedPage;
});

export default router;
