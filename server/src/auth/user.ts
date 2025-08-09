import { Task } from "@prisma/client";

export class UserEntity {
  id: number;
  email: string;
  username: string;
  password: string;
  tasks: Task[];
}
