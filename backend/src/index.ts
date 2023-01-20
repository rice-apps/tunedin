import Koa from 'koa';
import Router from '@koa/router';
import 'reflect-metadata';
import db from './db';
import userRouter from './routes/user';
import postRouter from './routes/post';
import authRouter from './routes/auth';

await db.initialize();

const PORT = 3000;

const app = new Koa();
const indexRouter = new Router();

app.use(indexRouter.routes());
app.use(indexRouter.allowedMethods());

app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.use(postRouter.routes());
app.use(postRouter.allowedMethods());

app.use(authRouter.routes());
app.use(authRouter.allowedMethods());

app.listen(PORT);

console.log(`Listening on Port ${PORT}...`);
