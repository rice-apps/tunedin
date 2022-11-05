import Koa from 'koa';
import Router from '@koa/router';
import userRouter from './routes/user';

const app = new Koa();
const indexRouter = new Router();

indexRouter.get('/', (ctx, next) => {
	ctx.body = {};
});

app.use(indexRouter.routes());
app.use(indexRouter.allowedMethods());

app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.listen(3000);
