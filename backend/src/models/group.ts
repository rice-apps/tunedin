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
	groupname: string;
    
	@Column()
	description: string;

    @Column()
    imagepath: string;
    
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

/*
Name (Stirng)
followers (collection of users)
members (collection of users)
description (string)
image ()
timeline (collection of post IDs)
/*
