import Router from '@koa/router';
import Post from '../models/post';
import User from '../models/user';
import mongodb from 'mongodb';
import bodyParser from 'koa-bodyparser';
import { MetadataWithSuchNameAlreadyExistsError } from 'typeorm';

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
	post.author.posts.push(post.id);

	const requestBody = ctx.request.body as any;
	const bodyText = requestBody.bodyText || '';
	const musicURL = requestBody.musicURL || '';

	post.bodyText = bodyText;
	post.musicURL = musicURL;
	post.createdAt = new Date();

	for (let i = 0; i < post.author.followers.length; i++) {
		post.author.followers[i].timeline.push(post.id);
	}

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

//delete post by postID
router.delete('/:postID', async (ctx, next) => {
	const post = Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	//get author of post
	const author = User.findOneBy(mongodb.ObjectId((await post).author));
	//remove post from author's posts
	(await author).posts = (await author).posts.filter(async (id) => {
		id !== (await post).id;
	});
});

router.delete('/', async (ctx, next) => {
	const posts = await Post.find();
	ctx.body = await Post.remove(posts);
});

export default router;
