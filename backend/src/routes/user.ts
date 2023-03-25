import Router from '@koa/router';
import User from '../models/user';
import Post from '../models/post';

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

router.get('/:username/followers', async (ctx, next) => {
	const user = await User.findOneBy({
		username: ctx.params.username,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = user.followers;
});

router.get('/timeline', async (ctx, next) => {
	const user = await User.findOneBy({
		username: ctx.state.user.id,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = user.timeline;
});

//get all users
router.get('/', async (ctx, next) => {
	ctx.body = await User.find();
});

router.put('/:name', async (ctx, next) => {
	const user = new User();
	if (await User.findOneBy({ username: ctx.params.username })) {
		ctx.status = 400;
	} else {
		user.username = ctx.state.user.id; //replace with auth
		user.name = ctx.params.name;
		user.followers = [];
		user.timeline = [];
		await user.save();
		ctx.body = user;
	}
});

router.post('/:username/timeline', async (ctx, next) => {
	const user = await User.findOneBy({
		username: ctx.params.username,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	const requestBody = ctx.request.body as any;
	const postID = requestBody.postID;
	user.timeline.push(postID);
	await user.save();
	ctx.body = user.timeline;
});

router.post('/following/:username2', async (ctx, next) => {
	const user1 = await User.findOneBy({
		username: ctx.state.user.id,
	});
	const user2 = await User.findOneBy({
		username: ctx.params.username2,
	});
	if (user1 === null || user2 === null) {
		ctx.status = 404;
		return;
	}
	//check to see if user is already following user2
	if (user2.followers.includes(user1.id)) {
		ctx.status = 400;
		return;
	}
	user2.followers.push(user1.id);
	await user2.save();
	user1.timeline = user1.timeline.concat(user2.posts);
	ctx.body = user2.followers;
});

router.post('/unfollowing/:username2', async (ctx, next) => {
	const user1 = await User.findOneBy({
		username: ctx.state.user.id,
	});
	const user2 = await User.findOneBy({
		username: ctx.params.username2,
	});
	if (user1 === null || user2 === null) {
		ctx.status = 404;
		return;
	}
	user2.followers = user2.followers.filter((id) => id !== user1.id);
	await user2.save();
	//remove all postIDs from user1.timeline authored by user2
	user1.timeline = user1.timeline.filter(async (id) => {
		const post = await Post.findOneBy(id);
		return post.author !== user2.id;
	});
	ctx.body = user2.followers;
});

router.delete('/', async (ctx, next) => {
	const users = await User.find();
	ctx.body = await User.remove(users);
});

export default router;
