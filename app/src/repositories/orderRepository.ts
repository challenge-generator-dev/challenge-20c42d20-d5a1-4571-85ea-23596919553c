import { Order } from '../models/order';
import { CreateOrderDTO, UpdateOrderDTO } from '../dtos/orderDTO';

export interface OrderRepository {
    create(order: CreateOrderDTO): Promise<Order>;
    findById(id: string): Promise<Order | null>;
    update(id: string, order: UpdateOrderDTO): Promise<Order | null>;
    delete(id: string): Promise<boolean>;
}

export class DynamoDBOrderRepository implements OrderRepository {
    async create(order: CreateOrderDTO): Promise<Order> {
        // TODO(reto): Implementar la lógica para crear una orden en DynamoDB
        throw new Error('Method not implemented.');
    }

    async findById(id: string): Promise<Order | null> {
        // TODO(reto): Implementar la lógica para buscar una orden por ID en DynamoDB
        throw new Error('Method not implemented.');
    }

    async update(id: string, order: UpdateOrderDTO): Promise<Order | null> {
        // TODO(reto): Implementar la lógica para actualizar una orden en DynamoDB
        throw new Error('Method not implemented.');
    }

    async delete(id: string): Promise<boolean> {
        // TODO(reto): Implementar la lógica para eliminar una orden en DynamoDB
        throw new Error('Method not implemented.');
    }
}