import Koa from 'koa';
import Router from '@koa/router';
import 'reflect-metadata';
import db from './db';
import userRouter from './routes/user';
import spotifyRouter from './routes/spotify';
import postRouter from './routes/post';
import groupRoute from './routes/group';
import authRouter from './routes/auth';
import { jwt } from './jwt';

await db.initialize();

const PORT = 3000;

const app = new Koa();
const indexRouter = new Router();
indexRouter.get('/', (ctx, next) => {
	ctx.body = {};
});

app.use(authRouter.routes());
app.use(authRouter.allowedMethods());

app.use(jwt);

app.use(indexRouter.routes());
app.use(indexRouter.allowedMethods());

app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.use(spotifyRouter.routes());
app.use(spotifyRouter.allowedMethods());

app.use(postRouter.routes());
app.use(postRouter.allowedMethods());
//Add group router
app.use(groupRoute.routes());
app.use(groupRoute.allowedMethods());

app.listen(PORT);

console.log(`Listening on Port ${PORT}...`);
