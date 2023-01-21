import Router from '@koa/router';
import User from '../models/user';

const router = new Router({
	prefix: '/users',
});

//Get all users
router.get('/', async (ctx, next) => {
	ctx.body = await User.find();
});

//Find user by handle
router.get('/:handle', async (ctx, next) => {
	const user = await User.findOneBy({
		handle: ctx.params.handle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}

	ctx.body = user;
});

//Create a new user
router.put('/:handle', async (ctx, next) => {
	const user = new User();
	user.handle = ctx.params.handle;
	user.displayname = 'John Doe';
	await user.save();
	ctx.body = user;
});

//Deletes all users
router.delete('/', async (ctx, next) => {
	const users = await User.find();
	ctx.body = await User.remove(users);
});

//Delete user by handle
router.delete('/:handle', async (ctx, next) => {
	const user = await User.findOneBy({
		handle: ctx.params.handle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = await User.remove(user);
});

export default router;
