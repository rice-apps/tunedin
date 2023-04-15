import Router from '@koa/router';
import Post from '../models/post';
import User from '../models/user';
import Comment from '../models/comment';
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
	const post = await Post.findOneBy({
		_id: mongodb.ObjectId(ctx.params.postID),
	});

	if (post === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = post;
});

router.post('/', async (ctx, next) => {
	const post = new Post();
	post._id = new mongodb.ObjectId();
	post.author = await User.findOneBy({
		_id: mongodb.ObjectId(ctx.state.user.id),
	});
	post.likedBy = [];
	post.comments = [];
	post.author.posts.push(post._id);
	post.author.timeline.push(post._id);

	const requestBody = ctx.request.body as any;
	const bodyText = requestBody.bodyText || '';
	const musicURL = requestBody.musicURL || '';

	post.bodyText = bodyText;
	post.musicURL = musicURL;
	post.createdAt = new Date();

	for (let i = 0; i < post.author.followers.length; i++) {
		post.author.followers[i].timeline.push(post._id);
	}
	await post.author.save();
	ctx.body = await post.save();
});

router.post('/:postID/like', async (ctx, next) => {
	// need to add field of liked posts to user model
	const post = await Post.findOneBy({
		_id: mongodb.ObjectId(ctx.params.postID),
	});

	const requestBody = ctx.request.body as any;
	const user = await User.findOneBy({
		_id: mongodb.ObjectId(ctx.state.user.id),
	});
	const dir = parseInt(requestBody.dir);

	if (post === null) {
		console.log(`Could not find post with ID: ${ctx.params.postID}`);
		ctx.status = 404;
		return;
	} else if (user === null) {
		ctx.status = 404;
		return;
	}
	// currently, we have no way of identifying based off the request given
	// so we will just use the handle parameter to identify the user
	if (dir === 1) {
		console.log(`Num post likes: ${post.likedBy.push(user._id)}`);
	} else {
		// if they unlike the post, remove them from the likedBy array
		// this covers the case where they have not liked the post yet
		post.likedBy = post.likedBy.filter((id) => !id.equals(user._id));
	}
	await post.save();
	ctx.body = post;
});

// delete a post by id
router.delete('/:postID', async (ctx, next) => {
	const post = await Post.findOneBy({
		_id: mongodb.ObjectId(ctx.params.postID),
	});
	ctx.body = await Post.remove(post);
});

router.delete('/', async (ctx, next) => {
	const posts = await Post.find();
	ctx.body = await Post.remove(posts);
});

//comment-related routes

//Get all comments from a post
router.get('/:postID/comments', async (ctx, next) => {
	const post = await Post.findOneBy({
		_id: mongodb.ObjectId(ctx.params.postID),
	});
	if (post === null) {
		console.log(`No Post associated with ID: ${ctx.params.postID}`);
		ctx.status = 404;
		return;
	}

	ctx.body = post.comments;
});

//Get a comment from a specific post.
router.get('/:postID/comments/:commentID', async (ctx, next) => {
	const comment = await Comment.findOneBy({
		_id: mongodb.ObjectId(ctx.params.commentID),
	});
	if (comment == null) {
		console.log(`No comment associated with ID: ${ctx.params.commendID}`);
		ctx.status = 404;
		return;
	}
	ctx.body = comment;
});

//add a comment to a post
// request body should contain bodyText
router.post('/:postID/comments', async (ctx, next) => {
	const post = await Post.findOneBy({
		_id: mongodb.ObjectId(ctx.params.postID),
	});
	if (post === null) {
		console.log(`No Post associated with ID: ${ctx.params.postID}`);
		ctx.status = 404;
		return;
	}
	// Create new comment
	const comment = new Comment();

	const requestBody = ctx.request.body as any;
	const bodyText = requestBody.bodyText || '';
	comment._id = new mongodb.ObjectId();
	comment.author = await User.findOneBy({
		_id: mongodb.ObjectId(ctx.state.user.id),
	});
	comment.likedBy = [];
	comment.bodyText = bodyText;

	await Comment.create(comment);
	await comment.save();
	post.comments.push(comment._id);
	await post.save();

	ctx.body = comment;
});

//delete a comment
router.delete('/:postID/comments/:commentID', async (ctx, next) => {
	const postID = mongodb.ObjectId(ctx.params.postID);
	const commentID = mongodb.ObjectId(ctx.params.commentID);

	const post = await Post.findOneBy({ _id: postID });
	if (post === null) {
		console.log('Post does not exist');
	}
	const comment = await Comment.findOneBy({ _id: commentID });
	if (comment === null) {
		console.log('Comment does not exist');
	}
	// filter comment from post by ID
	post.comments = post.comments.filter((id) => !id.equals(commentID));
	await post.save();
	ctx.body = await Comment.remove(comment);
});

//delete post by postID
router.delete('/:postID', async (ctx, next) => {
	const post = await Post.findOneBy({
		_id: mongodb.ObjectId(ctx.params.postID),
	});
	//get author of post
	const author = await User.findOneBy({ _id: mongodb.ObjectId(post.author) });
	//remove post from author's posts
	author.posts = author.posts.filter(async (id) => {
		id !== post._id;
	});

	for (let i = 0; i < post.author.followers.length; i++) {
		const follower = post.author.followers[i];
		// filter followers' timelines to not include this post
		follower.timeline = follower.timeline.filter(async (p: Post) => {
			return p._id !== post._id;
		});
	}
});

router.delete('/', async (ctx, next) => {
	const post = await Post.find();
	ctx.body = await Post.remove(post);
});

export default router;
