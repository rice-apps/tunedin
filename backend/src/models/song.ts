import { Entity, ObjectIdColumn, ObjectID, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';

/**
 * This is a model for a song.
 * The id is a key which directly represents a track in Spotify.
 */
@Entity()
class Song extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectID;
}

export default Song;
