import Koa from 'koa';
import Router from '@koa/router';
import 'reflect-metadata';
import db from './db';
import userRouter from './routes/user';
import spotifyRouter from './routes/spotify';

await db.initialize();

const app = new Koa();
const indexRouter = new Router();

const PORT = 3000;

indexRouter.get('/', (ctx, next) => {
	ctx.body = {};
});

app.use(indexRouter.routes());
app.use(indexRouter.allowedMethods());

app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.use(spotifyRouter.routes());
app.use(spotifyRouter.allowedMethods());

app.listen(PORT);

console.log(`Listening on Port ${PORT}`);
