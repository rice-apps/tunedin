import {
	Entity,
	ObjectIdColumn,
	BaseEntity,
	Column,
	ManyToMany,
	JoinTable,
} from 'typeorm';
import Song from './song';
import mongodb from 'mongodb';

/**
 * This is a model for a playlist.
 * The id is created on our end and does not represent a playlist's actual key in Spotify.
 * Playlists are related to songs in a Many to Many relation.
 */
@Entity()
class Playlist extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectID;

	@Column()
	name: string;

	@ManyToMany(() => Song)
	@JoinTable()
	songs: Song[];
}

export default Playlist;
