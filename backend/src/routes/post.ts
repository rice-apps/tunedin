import Router from '@koa/router';
import Post from '../models/post';
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
	post.numLikes += 1;
	await post.save();
	ctx.body = post;
});
router.post('/:postID/unlike', async (ctx, next) => {
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
