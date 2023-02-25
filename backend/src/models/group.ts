import {
	Entity,
	ObjectIdColumn,
	BaseEntity,
	Column,
	ManyToMany,
	JoinTable,
} from 'typeorm';
import User from './user';
import mongodb from 'mongodb';

@Entity()
class Group extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	handle: string;

	@Column()
	displayname: string;

	@Column()
	description: string;

	//Relation for a collection of users that follow the group

	@Column()
	followers: User[];

	@Column()
	members: User[];

	@Column()
	timeline: mongodb.ObjectId[];
}

export default Group;
