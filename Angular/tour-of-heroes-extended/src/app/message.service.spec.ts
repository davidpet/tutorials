import { TestBed } from '@angular/core/testing';

import { MessageService } from './message.service';

describe('MessageService', () => {
  let service: MessageService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MessageService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should start with no messages', () => {
    expect(service.messages.length).toBe(0);
  });

  it('should let you add messages', () => {
    service.add('howdy');
    service.add('hi there');

    expect(service.messages).toEqual(['howdy', 'hi there']);
  });

  it('should let you clear messages', () => {
    service.add('howdy');
    service.add('hi there');

    service.clear();

    expect(service.messages.length).toBe(0);
  });
});
