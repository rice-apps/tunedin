import Router from '@koa/router';
import axios from 'axios';
import User from '../models/user';
import jwt from 'jsonwebtoken';
import xml2js from 'xml2js';
import { stripPrefix } from 'xml2js/lib/processors';

import { CAS_SERVICE_URL, JWT_SECRET } from '../config';

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
	const ticket = ctx.request.header.ticket;

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
			// Create user
			user = new User();
			user.netid = netid;
			await user.save();
		}

		// Get a new jwt token for the user
		const token = createToken(user);

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
		const url = `${CASValidateURL}?ticket=${ticket}&service=${CAS_SERVICE_URL}/`;

		// First validate ticket against CAS, get a data object back
		const { data } = await axios.get(url);

		console.log('ticket: ' + ticket);
		console.log('data: ' + data);

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
					console.log('auth failed?');
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
		JWT_SECRET,
		{ expiresIn: '12h' }
	);
	return token;
};

export default router;
