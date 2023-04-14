import Router from '@koa/router';
import axios from 'axios';
import User from '../models/user';
import xml2js from 'xml2js';
import jwt from 'jsonwebtoken';
import { JWT_SECRET } from '../jwt';
import { stripPrefix } from 'xml2js/lib/processors';

import { CAS_SERVICE_URL } from '../config';

/**
 * Parser used for XML response by CAS
 */
const parser = new xml2js.Parser({
	tagNameProcessors: [stripPrefix],
	explicitArray: false,
});

const CAS_VALIDATE_URL = 'https://idp.rice.edu/idp/profile/cas/serviceValidate';

const router = new Router({
	prefix: '/auth',
});

router.get('/', async (ctx, next) => {
	// Ex: http://example.com/auth?ticket=ST-1590205338989-7y7ojqvDfvGIFDLyjahEqIp2F
	const ticket = ctx.request.header.ticket;

	const authenticationResponse = await authenticateTicket(ticket);
	if (authenticationResponse.success && 'netid' in authenticationResponse) {
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
			token: token,
			handle: user.handle,
		};
	} else {
		ctx.status = 401;
		ctx.body = { error: authenticationResponse.error };
	}
});

const authenticateTicket = async (ticket) => {
	try {
		// validate our ticket against the CAS server
		const url = `${CAS_VALIDATE_URL}?ticket=${ticket}&service=${CAS_SERVICE_URL}/`;

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
					return { success: true, netid: netid };
				} else {
					return { success: false, error: 'CAS authentication failed' };
				}
			},
			(err) => {
				return { success: false, error: 'Failed to parse CAS XML response' };
			}
		);
	} catch (e) {
		return { success: false, error: e.toString() };
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
