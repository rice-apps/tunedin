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
	if (group === null) {
		ctx.status = 404;
		return;
	}
	ctx.body = group;
});

router.put('/:grouphandle', async (ctx, next) => {
	const user = await User.findOneBy({
		_id: ctx.user.state.id,
	});
	if (user === null) {
		console.log('This user does not exist.');
		ctx.status = 404;
		return;
	}
	const body = ctx.request.body as any;
	if (!body) {
		ctx.status = 400;
		return;
	}
	const group = new Group();
	group.handle = ctx.state.user.handle;
	group.name = body.name;
	group.followers = [];
	group.members = [user];
	group.timeline = [];
	group.admin = [user];
	await group.save();
	ctx.body = group;
});

router.put('/makeadmin/:userhandle/:grouphandle', async (ctx, next) => {
	const admin = await User.findOneBy({
		handle: ctx.params.userhandle,
	});
	if (admin === null) {
		ctx.status = 404;
		return;
	}
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	group.admin.push(admin);
	await group.save();
	ctx.body = group;
});

router.put('/admingivesrights/:userhandle/:adminhandle/:grouphandle',async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const admin = await User.findOneBy({
		handle: ctx.params.adminhandle,
	});
	const admins = group.admin;
	if (!admins.includes(admin)) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		handle: ctx.params.userhandle,
	});
	
	if (admin === null) {
		ctx.status = 404;
		return;
	}
	
	group.admin.push(user);
	await group.save();
	ctx.body = group;
});

router.put('revokeadmin/:adminhandle/:deletedadminhandle/:grouphandle' ,async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const admin = await User.findOneBy({
		handle: ctx.params.adminhandle,
	});
	if (admin === null) {
		ctx.status = 404;
		return;
	}
	const admins = group.admin;
	if (!admins.includes(admin)) {
		ctx.status = 404;
		return;
	}
	const deletedadmin = await User.findOneBy({
		handle: ctx.params.deletedadminhandle,
	});
	if (deletedadmin === null) {
		ctx.status = 404;
		return;
	}
	if (!admins.includes(deletedadmin)) {
		ctx.status = 404;
		return;
	}
	
	group.admin = group.admin.filter((user) => user !== deletedadmin);
	await group.save();
	ctx.body = group;
})

router.put('/join/:grouphandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		_id: ctx.state.user.id,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.members.push(user);
	await group.save();
	ctx.body = group;
});

router.put('/follow/:grouphandle', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const user = await User.findOneBy({
		_id: ctx.state.user.id,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.followers.push(user);
	await group.save();
	ctx.body = group;
});

router.post('/removegrouppost/:adminhandle/:grouphandle/:postID', async (ctx, next) => {
	const group = await Group.findOneBy({
		handle: ctx.params.grouphandle,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}
	const admins = group.admin;
	
	const admin = await User.findOneBy({
		handle: ctx.params.adminhandle,
	});
	
	if (admin === null) {
		ctx.status = 404;
		return;
	}
	
	if (!admins.includes(admin)) {
		ctx.status = 404;
		return;
	}
	const timeline = group.timeline;

	if (!timeline.includes(ctx.params.postID)) {
		ctx.status = 404;
		return;
	}
	
	group.timeline = group.timeline.filter((post) => post !== ctx.params.postID);
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
		handle: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.members = group.members.filter((member) => member._id !== user._id);
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
		handle: ctx.params.userhandle,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}
	group.followers = group.followers.filter(
		(follower) => follower._id !== user._id
	);
	await group.save();
	ctx.body = group;
});

router.delete('/member/:adminhandle/:grouphandle/:userhandle', async (ctx, next) => {
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

	const admins = group.admin;

	if (user === null) {
		ctx.status = 404;
		return;
	}

	const admin = await User.findOneBy({
		handle: ctx.params.adminhandle,
	});

	if (!admins.includes(admin)) {
		ctx.status = 404;
		return;
	}

	group.members = group.members.filter((member) => member._id !== user._id);
	await group.save();
	ctx.body = group;
});

export default router;
