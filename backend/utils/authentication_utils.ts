// This will be created when the user logs in
import jwt from 'jsonwebtoken';

import axios from 'axios';

import xml2js from 'xml2js';

var stripPrefix = require('xml2js').processors.stripPrefix;

import { SECRET, SERVICE_URL } from '../config';
import User from '../src/models/user';

import passport from 'koa-passport';
import passportSaml from 'passport-saml';

const { Strategy } = passportSaml;

/**
 * Parser used for XML response by CAS
 */
const parser = new xml2js.Parser({
    tagNameProcessors: [stripPrefix],
    explicitArray: false
});

/**
 * Default failure response when authentication / verification doesn't work.
 */
const failureResponse = { success: false };

let config = {
    CASValidateURL: 'https://idp.rice.edu/idp/profile/cas/serviceValidate',
}

/**
 * Given a user, creates a new token for them.
 */
export const createToken = (user) => {
    let token = jwt.sign({
        id: user._id,
        netid: user.netid
    }, SECRET, { expiresIn: "12h" });
    return token;
}

/**
 * Given a token, finds the associated user.
 */
export const getUserFromToken = async (token) => {
    let returnUser = await User.findOneBy({ token: token });
    return returnUser;
}

/**
 * Given a token, verifies that it is still valid.
 */
export const verifyToken = async (token) => {
    try {
        // In the future, we may need the other properties...
        let { id, netid, iat, exp } = await jwt.verify(token, SECRET);
        return { success: true, id };
    } catch (e) {
        return failureResponse;
    }
}

/**
 * Given a ticket, authenticates it and returns the corresponding netid of the now-authenticated user.
 */
export const authenticateTicket = async (ticket) => {
    try {
        // validate our ticket against the CAS server
        var url = `${config.CASValidateURL}?ticket=${ticket}&service=${SERVICE_URL}`;

        // First validate ticket against CAS, get a data object back
        let { data } = await axios.get(url);

        // Parse returned XML data with xml2js parser
        return parser.parseStringPromise(data).then(
            (parsedResponse) => {
                let serviceResponse = parsedResponse.serviceResponse;
                // This object contains the information as to whether this login was successful
                var authSucceded = serviceResponse.authenticationSuccess;
                if (authSucceded) {
                    // authSucceded.user is the netid
                    let netid = authSucceded.user;
                    return { success: true, netid };
                } else {
                    return failureResponse;
                }
            },
            (err) => {
                console.log("Error!");
                return failureResponse;
            }
        );
    } catch (e) {
        console.log("Something went wrong.");
        return failureResponse;
    }
}