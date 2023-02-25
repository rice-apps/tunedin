import Router from '@koa/router';
import Post from '../models/post';
import User from '../models/user';
import Comment from '../models/Comment';
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
	post.likedBy = [];
	post.comments = [];

	const requestBody = ctx.request.body as any;
	const bodyText = requestBody.bodyText || '';
	const musicURL = requestBody.musicURL || '';

	post.bodyText = bodyText;
	post.musicURL = musicURL;

	await Post.create(post);
	ctx.body = await post.save();
});
router.post('/:postID/like', async (ctx, next) => {
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));

	const requestBody = ctx.request.body as any;
	const username = requestBody.username;
	const dir = parseInt(requestBody.dir);
	console.log(username);
	console.log(dir);

	if (post === null) {
		console.log(`Could not find post with ID: ${ctx.params.postID}`);
		ctx.status = 404;
		return;
	}
	// currently, we have no way of identifying based off the request given
	// so we will just use the username parameter to identify the user
	if (username) {
		const user = await User.findOneBy({
			username: username,
		});
		console.log(user);
		if (user === null) {
			console.log(`Could not find user with name: ${username}`);
			ctx.status = 404;
			return;
		}
		if (dir === 1) {
			console.log(`Num post likes: ${post.likedBy.push(user.id)}`);
		} else {
			// if they unlike the post, remove them from the likedBy array
			// this covers the case where they have not liked the post yet
			post.likedBy = post.likedBy.filter((id) => !id.equals(user.id));
		}
		await post.save();
	}
	// await Post.save(post);
	ctx.body = post;
});
// delete a post by id
router.delete('/:postID', async (ctx, next) => {
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	ctx.body = await Post.remove(post);
});
// delete all posts
router.delete('/', async (ctx, next) => {
	const post = await Post.find();
	ctx.body = await Post.remove(post);
});

//comment-related routes

//Get a comment from a specific post.
router.get('/:postID/comments/:commentID', async (ctx, next) => {
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));

	const commentID = mongodb.ObjectId(ctx.params.commentID);
	const comment = post.comments.find((id) => id === commentID);

	ctx.body = comment;
});

//add a comment to a post
router.post('/:postID/comments/', async (ctx, next) => {
	const comment = new Comment();
	// Get comment data from request body
	const requestBody = ctx.request.body as any;
	const bodyText = requestBody.bodyText || '';
	// assign fields to comment
	comment.id = new mongodb.ObjectId();
	comment.author = null; // TBD USING AUTH
	comment.likedBy = [];
	comment.bodyText = bodyText;

	await comment.save();
	ctx.body = comment;
});

//delete a comment
router.delete('/:postID/comments/:commentID', async (ctx, next) => {
	const postID = mongodb.ObjectId(ctx.params.postID);
	const commentID = mongodb.ObjectId(ctx.params.commendID);

	const post = await Post.findOneBy(postID);
	const comment = await Comment.findOneBy(commentID);

	// filter comment from post by ID
	post.comments = post.comments.filter((id) => id !== commentID);
	ctx.body = await Comment.remove(comment);
});

//like or unlike comment.
/* 
	Request Body Structure:
		username: username of the person liking / unliking
		dir: 1 if liking, 0 otherwise
*/
router.post('/:postID/comments/:commentID', async (ctx, next) => {
	const post = await Post.findOneBy(mongodb.ObjectId(ctx.params.postID));
	const comment = await Comment.findOneBy(
		mongodb.ObjectId(ctx.params.commentID)
	);

	const requestBody = ctx.request.body as any;
	const username = requestBody.username;
	const dir = requestBody.dir;

	if (post === null || comment === null) {
		ctx.status = 404;
		return;
	}
	// currently, we have no way of identifying based off the request given
	// so we will just use the username parameter to identify the user
	if (username) {
		const user = await User.findOneBy({
			username: username,
		});
		if (user === null) {
			ctx.status = 404;
			return;
		}
		if (dir === 1) {
			comment.likedBy.push(user.id);
		} else {
			// if they unlike the post, remove them from the likedBy array
			// this covers the case where they have not liked the post yet
			comment.likedBy = comment.likedBy.filter((id) => id !== user.id);
		}
		await comment.save();
	}
	ctx.body = comment.likedBy.length;
});

export default router;
