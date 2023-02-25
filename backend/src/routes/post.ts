import Router from '@koa/router';
import Post from '../models/post';
import User from '../models/user';
import mongodb from 'mongodb';
import bodyParser from 'koa-bodyparser';

const router = new Router({
	prefix: '/posts',
});

router.use(bodyParser());

router.get('/', async (ctx, next) => {
	ctx.body = await Post.find();
});

router.get('/:postID', async (ctx, next) => {
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));

	if (post === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = post;
});
router.post('/', async (ctx, next) => {
	const post = new Post();
	post.id = new mongodb.ObjectId();
	post.author = null; //This is dependent on Auth to determine the author
	post.numLikes = 0;

	const requestBody = ctx.request.body as any;
	const bodyText = requestBody.bodyText || '';
	const musicURL = requestBody.musicURL || '';

	post.bodyText = bodyText;
	post.musicURL = musicURL;

	await post.save();
	ctx.body = post;
});
router.post('/:postID/like', async (ctx, next) => {
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	if (post === null) {
		ctx.status = 404;
		return;
	}
	// currently, we have no way of identifying based off the request given
	// so we will just use the username parameter to identify the user
	if (ctx.request.body.username) {
		const user = await User.findOneBy({
			username: ctx.request.body.username,
		});s
		if (user === null) {
			ctx.status = 404;
			return;
		}
		if (ctx.request.body.dir === 1) {
		    post.likedBy.push(user);
		} else {
			// if they unlike the post, remove them from the likedBy array
			// this covers the case where they have not liked the post yet
			post.likedBy = post.likedBy.filter((u) => u.id !== user.id);
		}
		await post.save()
	}
});

router.delete('/', async (ctx, next) => {
	const post = await Post.find();
	ctx.body = await Post.remove(post);
});

export default router;
