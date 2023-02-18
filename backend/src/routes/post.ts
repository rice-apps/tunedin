import Router from '@koa/router';
import Post from '../models/post';
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
	const parentCommentID = requestBody.parentCommentID || null;
	// assign fields to comment
	comment.id = new mongodb.ObjectId();
	comment.author = null; // TBD USING AUTH
	comment.numLikes = 0;
	comment.parentCommentID = parentCommentID;
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
	// delete comment if it's a reply
	if (comment.parentCommentID) {
		Comment.remove(comment);
	} else {
		// delete if comment on a post
		post.comments.filter((id) => id === commentID);
	}
});

export default router;
