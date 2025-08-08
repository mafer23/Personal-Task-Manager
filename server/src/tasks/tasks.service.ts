import { Injectable, NotFoundException, BadRequestException } from "@nestjs/common";
import { Task } from "@prisma/client";
import { PrismaService } from "prisma/prisma.service";
import { CreateTaskDto } from "./dtos/CreateTaskDto";
import { UpdateTaskDto } from "./dtos/UpdateTaskDto";
import { Prisma } from "@prisma/client";

@Injectable()
export class TasksService {
    constructor(private prisma: PrismaService) {}

    async getTasks(): Promise<Task[]> {
        return await this.prisma.task.findMany();
    }

    async getTaskById(id: number): Promise<Task> {
        const task = await this.prisma.task.findUnique({ where: { id } });
        if (!task) {
            throw new NotFoundException(`No se encontró la tarea con ID ${id}`);
        }
        return task;
    }

    async createTask(data: CreateTaskDto): Promise<Task> {
        try {
            return await this.prisma.task.create({ data });
        } catch (error) {
            if (error instanceof Prisma.PrismaClientKnownRequestError) {
                throw new BadRequestException('Error al crear la tarea');
            }
            throw error;
        }
    }

    async updateTask(id: number, data: UpdateTaskDto): Promise<Task> {
        try {
            return await this.prisma.task.update({
                where: { id },
                data,
            });
        } catch (error) {
            if (error instanceof Prisma.PrismaClientKnownRequestError && error.code === 'P2025') {
                throw new NotFoundException(`No se encontró la tarea con ID ${id} para actualizar`);
            }
            throw error;
        }
    }

    async deleteTask(id: number): Promise<Task> {
        try {
            return await this.prisma.task.delete({ where: { id } });
        } catch (error) {
            if (error instanceof Prisma.PrismaClientKnownRequestError && error.code === 'P2025') {
                throw new NotFoundException(`No se encontró la tarea con ID ${id} para eliminar`);
            }
            throw error;
        }
    }
}
