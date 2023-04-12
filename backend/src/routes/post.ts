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
	post.author = await User.findOneBy(mongodb.ObjectId(ctx.state.user.id));
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
	// need to add field of liked posts to user model
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
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	//get author of post
	const author = await User.findOneBy(mongodb.ObjectId(post.author));
	//remove post from author's posts
	author.posts = author.posts.filter(async (id) => {
		id !== post.id;
	});

	for (let i = 0; i < post.author.followers.length; i++) {
		const follower = post.author.followers[i];
		// filter followers' timelines to not include this post
		follower.timeline = follower.timeline.filter(async (p: Post) => {
			return p.id !== post.id;
		});
	}
});

router.delete('/', async (ctx, next) => {
	const posts = await Post.find();
	ctx.body = await Post.remove(posts);
});

export default router;
