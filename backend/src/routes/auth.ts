import Router from '@koa/router';
import axios from 'axios';
import User from '../models/user';
import jwt from 'jsonwebtoken';
import xml2js from 'xml2js';
import { stripPrefix } from 'xml2js/lib/processors';

// CHANGE
const SECRET = 'test_secret';

/**
 * Parser used for XML response by CAS
 */
const parser = new xml2js.Parser({
	tagNameProcessors: [stripPrefix],
	explicitArray: false,
});

/**
 * Default failure response when authentication / verification doesn't work.
 */
const failureResponse = { success: false, netid: null };

const CASValidateURL = 'https://idp.rice.edu/idp/profile/cas/serviceValidate';

const router = new Router({
	prefix: '/auth',
});

// router.use(bodyParser());

router.get('/', async (ctx, next) => {
	// Ex: http://example.com/auth?ticket=ST-1590205338989-7y7ojqvDfvGIFDLyjahEqIp2F
	const ticket = ctx.params.ticket;
	const authenticationResponse = await authenticateTicket(ticket);
	if (authenticationResponse.success) {
		// Get the netid of the authenticated user
		let { netid } = authenticationResponse;

		// force netid to be lowercase to prevent duplicate user bug
		netid = netid.toLowerCase();

		// Check if user exists based on netid
		let user = await User.findOne({
			where: {
				netid: netid,
			},
		});

		if (!user) {
			// Create user + redirect to onboarding
			user = new User();
			user.netid = netid;
			await user.save();
		}

		// Get a new token for the user
		const token = createToken(user);
		user.token = token;
		await user.save();

		ctx.body = {
			success: true,
			message: 'CAS authentication success',
			user: {
				netid: user.netid,
				token: token,
			},
		};

		// Update the user's token and get their updated information
		return user.save();
	} else {
		ctx.status = 401;
		ctx.body = { success: false, message: 'CAS authentication failed' };
	}
});

const authenticateTicket = async (ticket) => {
	try {
		// validate our ticket against the CAS server
		const url = `${CASValidateURL}?ticket=${ticket}&service=localhost:3000/auth`;

		// First validate ticket against CAS, get a data object back
		const { data } = await axios.get(url);

		// Parse returned XML data with xml2js parser
		return parser.parseStringPromise(data).then(
			(parsedResponse) => {
				const serviceResponse = parsedResponse.serviceResponse;
				// This object contains the information as to whether this login was successful
				const authSucceeded = serviceResponse.authenticationSuccess;
				if (authSucceeded) {
					// authSucceded.user is the netid
					const netid = authSucceeded.user;
					return { success: true, netid };
				} else {
					return failureResponse;
				}
			},
			(err) => {
				console.log('Error!');
				return failureResponse;
			}
		);
	} catch (e) {
		console.log('Something went wrong.');
		return failureResponse;
	}
};

const createToken = (user: User): string => {
	const token = jwt.sign(
		{
			id: user.id,
			netid: user.netid,
		},
		SECRET,
		{ expiresIn: '12h' }
	);
	return token;
};

export default router;
