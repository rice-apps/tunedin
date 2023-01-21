import {
	Entity,
	ObjectIdColumn,
	BaseEntity,
	Column,
	ManyToMany,
	JoinTable,
} from 'typeorm';
import User from './user'
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
	@ManyToMany(() => User)
	@JoinTable()
	followers: User[];
    
    @ManyToMany(() => User)
	@JoinTable()
	members: User[];

    @ManyToMany(() => User)
	@JoinTable()
	timeline: mongodb.ObjectId[];
}

export default Group;

