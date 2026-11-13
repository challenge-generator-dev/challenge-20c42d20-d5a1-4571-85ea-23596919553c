import { IsArray, IsNumber, IsOptional, IsString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class ProductDTO {
    @IsString()
    productId: string;

    @IsNumber()
    quantity: number;

    @IsNumber()
    price: number;
}

export class CreateOrderDTO {
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => ProductDTO)
    products: ProductDTO[];

    @IsOptional()
    @IsString()
    status?: string;
}

export class UpdateOrderDTO {
    @IsOptional()
    @IsString()
    status?: string;

    @IsOptional()
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => ProductDTO)
    products?: ProductDTO[];
}

export class OrderResponseDTO {
    @IsString()
    id: string;

    @IsString()
    createdAt: string;

    @IsString()
    status: string;

    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => ProductDTO)
    products: ProductDTO[];

    constructor(id: string, createdAt: string, status: string, products: ProductDTO[]) {
        this.id = id;
        this.createdAt = createdAt;
        this.status = status;
        this.products = products;
    }
}

export function toOrderResponseDTO(order: any): OrderResponseDTO {
    return new OrderResponseDTO(
        order.id,
        order.createdAt,
        order.status,
        order.products.map((p: any) => ({
            productId: p.productId,
            quantity: p.quantity,
            price: p.price
        }))
    );
}