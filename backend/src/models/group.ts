import { Entity, ObjectIdColumn, BaseEntity, Column } from 'typeorm';
import User from './user';
import mongodb from 'mongodb';

@Entity()
class Group extends BaseEntity {
	@ObjectIdColumn()
	_id: typeof mongodb.ObjectId;

	@Column()
	handle: string;

	@Column()
	name: string;

	@Column()
	description: string;

	//Relation for a collection of users that follow the group

	@Column()
	followers: User[];

	@Column()
	members: User[];

	@Column()
	timeline: mongodb.ObjectId[];

	@Column()
	admin: User[];
}

export default Group;
