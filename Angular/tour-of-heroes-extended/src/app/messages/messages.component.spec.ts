import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MessagesComponent } from './messages.component';
import { MessageService } from '../message.service';

describe('MessagesComponent', () => {
  let component: MessagesComponent;
  let fixture: ComponentFixture<MessagesComponent>;

  let messageServiceSpy: jasmine.SpyObj<MessageService>;

  beforeEach(() => {
    messageServiceSpy = jasmine.createSpyObj(MessageService.name, [
      'add',
      'clear',
      'messages',
    ]);
    messageServiceSpy.messages = [];

    TestBed.configureTestingModule({
      declarations: [MessagesComponent],
      providers: [{ provide: MessageService, useValue: messageServiceSpy }],
    });
    fixture = TestBed.createComponent(MessagesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should not show if no message', () => {
    expect(fixture.nativeElement.querySelector('.messages')).toBeFalsy();
  });

  it('should show messages', () => {
    const messages = ['message1', 'message2'];

    messageServiceSpy.messages = messages;
    fixture.detectChanges();

    expect(fixture.nativeElement.querySelector('.messages')).toBeTruthy();
    const messageElements: HTMLElement[] = Array.from(
      fixture.nativeElement.querySelectorAll('.message')
    );
    const messageTexts = messageElements.map((e) => e.textContent?.trim());
    expect(messageTexts).toEqual(messages);
  });

  it('should clear messages on click', () => {
    const messages = ['message1', 'message2'];
    messageServiceSpy.messages = messages;
    fixture.detectChanges();

    messageServiceSpy.clear.calls.reset();
    fixture.nativeElement.querySelector('button').click();
    fixture.detectChanges();

    expect(messageServiceSpy.clear).toHaveBeenCalled();
  });
});
