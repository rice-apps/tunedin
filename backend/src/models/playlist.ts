import { Entity, ObjectIdColumn, ObjectID, BaseEntity, Column } from 'typeorm';

/**
 * This is a model for a playlist.
 * The id is created on our end and does not represent a playlist's actual key in Spotify.
 * Playlists are related to songs in a Many to Many relation.
 */
@Entity()
class Playlist extends BaseEntity {
	@ObjectIdColumn()
	id: typeof ObjectID;

	@Column()
	name: string;
}

export default Playlist;
