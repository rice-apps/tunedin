import Router from '@koa/router';
import User from '../models/user';
import Post from '../models/post';
import mongodb from 'mongodb';
import bodyParser from 'koa-bodyparser';
import db from '../db';

const router = new Router({
	prefix: '/users',
});

router.use(bodyParser());

router.get('/', async (ctx, next) => {
	ctx.body = await User.find();
});

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

router.get('/:handle/followers', async (ctx, next) => {
	const user = await User.findOneBy({
		handle: ctx.params.handle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = user.followers;
});

router.get('/:handle/timeline', async (ctx, next) => {
	const user = await User.findOne(mongodb.ObjectId(ctx.state.user.id));
	if (user === null) {
		ctx.status = 404;
		return;
	}

	const postIDs = user.timeline;

	const timeline = await db.getRepository(Post).find({
		where: {
			_id: { $in: postIDs },
		},
		order: {
			createdAt: 'DESC',
		},
		take: 30,
	});

	ctx.body = timeline;
});

router.put('/:handle/', async (ctx, next) => {
	const user = new User();
	const body = ctx.request.body as any;

	if (await User.findOneBy({ handle: ctx.params.handle })) {
		ctx.status = 400;
	} else {
		user.handle = ctx.params.handle;
		user.name = body.name || '';
		user.netid = body.netid || '';
		user.followers = [];
		user.timeline = [];
		await user.save();
		ctx.body = user;
	}
});

router.put('/:handle/edit', async (ctx, next) => {
	const user = await User.findOneBy({ handle: ctx.params.handle });
	const body = ctx.request.body as any;

	if (!user || !body) {
		ctx.status = 400;
	} else {
		user.name = body.name;
		await user.save();
		ctx.body = user;
	}
});

router.post('/follow/:handle', async (ctx, next) => {
	const user = await User.findOneBy({
		_id: mongodb.ObjectId(ctx.state.user.id),
	});
	const following = await User.findOneBy({
		handle: ctx.params.handle,
	});
	if (user === null || following === null) {
		ctx.status = 404;
		return;
	}
	//check to see if user is already following them
	if (following.followers.includes(user._id)) {
		ctx.status = 400;
		return;
	}
	following.followers.push(user._id);
	await following.save();
	user.timeline = user.timeline.concat(following.posts);
	ctx.body = following.followers;
});

router.post('/unfollow/:handle', async (ctx, next) => {
	const user = await User.findOneBy({
		_id: mongodb.ObjectId(ctx.state.user.id),
	});
	const unfollowing = await User.findOneBy({
		handle: ctx.params.handle,
	});
	if (user === null || unfollowing === null) {
		ctx.status = 404;
		return;
	}
	unfollowing.followers = unfollowing.followers.filter((id) => id !== user._id);
	await unfollowing.save();
	//remove all postIDs from user.timeline authored by unfollowing
	user.timeline = user.timeline.filter(async (id) => {
		const post = await Post.findOneBy({ _id: id });
		return post.author !== unfollowing._id;
	});
	ctx.body = unfollowing.followers;
});

router.delete('/', async (ctx, next) => {
	const users = await User.find();
	ctx.body = await User.remove(users);
});

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
