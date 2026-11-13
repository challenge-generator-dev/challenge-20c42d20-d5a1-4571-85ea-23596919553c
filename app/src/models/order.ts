import { v4 as uuidv4 } from 'uuid';

export interface Product {
    productId: string;
    quantity: number;
    price: number;
}

export class Order {
    id: string;
    createdAt: string;
    status: string;
    products: Product[];

    constructor(products: Product[], status: string = 'pending') {
        if (!products || products.length === 0) {
            throw new Error('Order must have at least one product');
        }

        this.id = uuidv4();
        this.createdAt = new Date().toISOString();
        this.status = status;
        this.products = products;
    }

    updateStatus(newStatus: string): void {
        const validStatuses = ['pending', 'processing', 'shipped', 'delivered', 'cancelled'];
        if (!validStatuses.includes(newStatus)) {
            throw new Error(`Invalid status: ${newStatus}`);
        }
        this.status = newStatus;
    }

    updateProducts(newProducts: Product[]): void {
        if (!newProducts || newProducts.length === 0) {
            throw new Error('Order must have at least one product');
        }
        this.products = newProducts;
    }

    calculateTotal(): number {
        return this.products.reduce((total, product) => {
            return total + (product.price * product.quantity);
        }, 0);
    }
}