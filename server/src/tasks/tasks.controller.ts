import { Controller,Get,Post,Put,Delete, Body,Param} from "@nestjs/common";
import { TasksService } from "./tasks.service";
import { CreateTaskDto } from "./dtos/CreateTaskDto";
import { UpdateTaskDto } from "./dtos/UpdateTaskDto";
 
@Controller('tasks')
export class TasksController {
  constructor(private readonly tasksService: TasksService) {}

  @Get()
  findAll() {
    return this.tasksService.getTasks();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.tasksService.getTaskById(Number(id));
  }

  @Post()
  create(@Body() task: CreateTaskDto) {
    return this.tasksService.createTask(task);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() task: UpdateTaskDto) {
    return this.tasksService.updateTask(Number(id), task);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.tasksService.deleteTask(Number(id));
  }

}