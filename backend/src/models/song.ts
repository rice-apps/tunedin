import { Entity, ObjectIdColumn, ObjectID, BaseEntity, ManyToMany, JoinTable } from 'typeorm';
import Playlist from './playlist';

/**
 * This is a model for a song.
 * The id is a key which directly represents a track in Spotify.
 */
@Entity()
class Song extends BaseEntity {
    @ObjectIdColumn()
    id: typeof ObjectID;

    @ManyToMany(() => Playlist)
    @JoinTable()
    playlists: Playlist[];
}

export default Song;