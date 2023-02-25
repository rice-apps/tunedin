import Koa from 'koa';
import Router from '@koa/router';
import 'reflect-metadata';
import db from './db';
import userRouter from './routes/user';
import postRouter from './routes/post';
import groupRoute from './routes/group';

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
//Add group router
app.use(groupRoute.routes());
app.use(groupRoute.allowedMethods());

app.listen(PORT);

console.log(`Listening on Port ${PORT}...`);
