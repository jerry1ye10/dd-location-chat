import functions from "firebase-functions";
import admin from "firebase-admin";
import axios from "axios";

admin.initializeApp();

const SENDBIRD_API_KEY = "TODO_CAN_I_USE_DOTENV_IN_CLOUD_FN";
const SENDBIRD_APP_ID = "SENDBIRD_APP_ID";
const SENDBIRD_BASE_URL = `https://api-${application_id}.sendbird.com/v3/`

type UserID = string;
type CommunityID = string;

interface UserDoc {
	id: UserID;
	communityID: CommunityID;
	currentCity: string;
}

export const createGC = functions.https.onRequest(async (req, res) => {
	const callerID = req.query.userID;
	const callerRes = await admin.firestore().collection("userInfo").where("id", "==", callerID).get();
	if (callerRes.empty) {
		res.error({ error: "user not found" });
		return;
	}

	const caller = callerRes.docs[0].ref.get().data();

	const membersRes = await admin.firestore().collection("userInfo").where("communityID", "==", caller.communityID).get();
	const members = [];
	membersRes.forEach(memberRef => {
		const member = memberRef.ref.get().data();
		members.push(member.id);
	});
	
	const sendbirdRes = await axios.post(SENDBIRD_BASE_URL + "group_channels", {
		users: members
	}, );

	if (sendbirdRes.status !== 200) {
		res.error({ error:`"sendbird error: ${sendbirdRes.statusText}`});
		return;
	}

	const channelID = sendbirdRes.data.channel_url;
	res.json({ channelID });
});
