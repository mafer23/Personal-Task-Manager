import { Injectable } from "@nestjs/common";
import { Task } from "@prisma/client";
import { PrismaService } from "prisma/prisma.service";
import { CreateTaskDto } from "./dtos/CreateTaskDto";
import { UpdateTaskDto } from "./dtos/UpdateTaskDto";


@Injectable()
export class TasksService {
    constructor(private prisma: PrismaService) {}

    async getTasks(): Promise<Task[]> {
        return await this.prisma.task.findMany();
    }

    async getTaskById(id: number): Promise<Task | null> {
        return await this.prisma.task.findUnique({
            where: { id },
        });
    }

    async createTask(data: CreateTaskDto): Promise<Task> {
        return await this.prisma.task.create({
            data,
        });
    }

    async updateTask(id: number, data: UpdateTaskDto): Promise<Task> {
        return await this.prisma.task.update({
            where: { id },
            data,
        });
    }

    async deleteTask(id: number): Promise<Task | null> {
        return await this.prisma.task.delete({
            where: { id },
        });
    }
}