import Router from '@koa/router';
import User from '../models/user';
import { createToken, verifyToken } from '../../utils/authentication_utils';
import { create } from 'domain';

const router = new Router({
	prefix: '/users',
});

router.get('/', async (ctx, next) => {
	ctx.body = await User.find();
});

router.get('/:username', async (ctx, next) => {
	const user = await User.findOneBy({
		username: ctx.params.username,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}

	ctx.body = user;
});

router.put('/:username', async (ctx, next) => {
	const user = new User();
	user.username = ctx.params.username;
	user.name = 'John Doe';
	await user.save();
	ctx.body = user;
});

router.post('/login/:token', async (ctx, next) => {
	// call the functions that we've written in authentication_utils
	// to get the information from the post body, use the body parser package (Shreyas will send link to body parser package)
	const user = new User();
	user.username = ctx.params.username;
	const token = createToken(user);
	verifyToken(token);
	user.token = token;
	
	// to actually test, run a local instance of MongoDB and run it using npm start
});

router.delete('/', async (ctx, next) => {
	const users = await User.find();
	ctx.body = await User.remove(users);
});



export default router;
