import Koa from 'koa';
import Router from '@koa/router';
import 'reflect-metadata';
import db from './db';
import userRouter from './routes/user';
import SpotifyWebApi from 'spotify-web-api-node';

await db.initialize();

const app = new Koa();
const indexRouter = new Router();

// credentials are optional
var spotifyApi = new SpotifyWebApi({
	clientId: 'fcecfc72172e4cd267473117a17cbd4d',
	clientSecret: 'a6338157c9bb5ac9c71924cb2940e1a7',
	redirectUri: 'http://www.example.com/callback',
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

indexRouter.get('/', (ctx, next) => {
	ctx.body = {};
});

app.use(indexRouter.routes());
app.use(indexRouter.allowedMethods());

app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.listen(3000);
