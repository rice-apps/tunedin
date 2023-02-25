import Router from '@koa/router';
import Group from '../models/group';
import User from '../models/user';

const router = new Router({
	prefix: '/groups',
});

router.get('/', async (ctx, next) => {
	ctx.body = await Group.find();
});

// Finds group by handle.
router.get('/:grouphandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	console.log(group);
	if (group === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = group;
});

//Create a new group with required group handle and display name.
router.put('/:grouphandle/:displayname/:creatorhandle', async (ctx, next) => {
	// once auth is set up, fix this to use object id provided by auth info.
	const user = await User.findOneBy({
		handle: ctx.params.creatorhandle,
	});
	if (user === null) {
		console.log('This user does not exist.');
		ctx.status = 404;
		return;
	}
	const group = new Group();
	group.handle = ctx.params.grouphandle;
	group.displayname = ctx.params.displayname;
	//Create new user array for followers and members.
	group.followers = [];
	group.members = [user];
	group.timeline = [];
	await group.save();
	ctx.body = group;
});

// Add user to a group.
router.put('/member/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		handle: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.members.push(user);
	await group.save();
	ctx.body = group;
});

// Add folower to group.
router.put('/follower/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		handle: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.followers.push(user);
	await group.save();
	ctx.body = group;
});

// Delete all groups.
router.delete('/', async (ctx, next) => {
	ctx.body = await Group.clear();
	// const groups = await Group.find();
	// ctx.body = await Group.remove(groups);
});

// Delete group by handle.
router.delete('/:grouphandle', async (ctx, next) => {
	Group.delete({ handle: ctx.params.grouphandle });
});

//Delete user from group by handle
router.delete('/member/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		handle: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.members = group.members.filter((member) => member.id !== user.id);
	await group.save();
	ctx.body = group;
});

//Delete follower from group by handle
router.delete('/follower/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		handle: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.followers = group.followers.filter(
		(follower) => follower.id !== user.id
	);
	await group.save();
	ctx.body = group;
});

export default router;
