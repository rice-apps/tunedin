import Router from '@koa/router';
import Post from '../models/post';
import mongodb from 'mongodb';

const router = new Router({
	prefix: '/posts',
});

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
router.post('/:netID/:body/:musicURL', async (ctx, next) => {
	const post = new Post();
	post.id = new mongodb.ObjectId();
	post.netID = ctx.params.netID;
	post.numLikes = 0;
	post.bodyText = ctx.params.body;
	post.musicURL = ctx.params.musicURL;

	await post.save();
	ctx.body = post;
});
router.post('/:postID/like', async (ctx, next) => {
	console.log(ctx.params.postID);
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	if (post === null) {
		ctx.status = 404;
		return;
	}
	post.numLikes += 1;
	await post.save();
	ctx.body = post;
});
router.post('/:postID/unlike', async (ctx, next) => {
	console.log(ctx.params.postID);
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	if (post === null) {
		ctx.status = 404;
		return;
	}
	post.numLikes -= 1;
	await post.save();
	ctx.body = post;
});

router.delete('/', async (ctx, next) => {
	const post = await Post.find();
	ctx.body = await Post.remove(post);
});

export default router;
