import Router from '@koa/router';
import Group from '../models/group';
import User from '../models/user';

const router = new Router({
	prefix: '/groups',
});

router.get('/', async (ctx, next) => {
	ctx.body = await Group.find();
});

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

router.put('/:grouphandle', async (ctx, next) => {
	const user = await User.findOneBy({
		username: ctx.params.creatorhandle,
	});
	if (user === null) {
		console.log('This user does not exist.');
		ctx.status = 404;
		return;
	}
	const group = new Group();
	group.handle = ctx.state.user.handle;
	group.displayname = ctx.state.user.displayname;
	group.followers = [];
	group.members = [user];
	group.timeline = [];
	await group.save();
	ctx.body = group;
});

router.put('/member/:grouphandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		handle: ctx.state.user.handle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.members.push(user);
	await group.save();
	ctx.body = group;
});

router.put('/follower/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		username: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.followers.push(user);
	await group.save();
	ctx.body = group;
});

router.delete('/', async (ctx, next) => {
	ctx.body = await Group.clear();
});

router.delete('/:grouphandle', async (ctx, next) => {
	Group.delete({ handle: ctx.params.grouphandle });
});

router.delete('/member/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		username: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.members = group.members.filter((member) => member.id !== user.id);
	await group.save();
	ctx.body = group;
});

router.delete('/follower/:grouphandle/:userhandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		username: ctx.params.userhandle,
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
