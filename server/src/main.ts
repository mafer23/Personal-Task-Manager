import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AllExceptionsFilter } from './common/filter/http-exception.filter';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
    app.useGlobalFilters(new AllExceptionsFilter());

    app.enableCors({
    origin: '*', 
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });



  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
