from database import db
from sqlalchemy import ForeignKey


class Ticket(db.Model):
    __tablename__ = 'Ticket'
    id = db.Column(db.String(32), primary_key=True)
    bus_no = db.Column(db.String(32), nullable=False)
    starting_bus_stop = db.Column(db.String(100), nullable=False)
    end_bus_stop = db.Column(db.String(100), nullable=False)
    starting_bus_timing = db.Column(db.String(100), nullable=False)
    timings_and_no_of_stop = db.Column(db.String(100), nullable=False)
    origin_to_destination = db.Column(db.Boolean, nullable=False)
    status = db.Column(db.Integer, nullable=False)


class BookedTickets(db.Model):
    __tablename__ = 'BookedTickets'
    id = db.Column(db.String(32), primary_key=True)
    user_id = db.Column(db.String(32), ForeignKey('User.id'))
    tickets = db.Column(db.JSON(), nullable=False)
    number_of_tickets = db.Column(db.Integer, nullable=False)
    face_id = db.Column(db.JSON(), nullable=False)
    toatal_time = db.Column(db.String(100), nullable=False)
    amount_payed = db.Column(db.Integer, nullable=False)
    status = db.Column(db.Boolean, nullable=False)
    booked_date_time = db.Column(db.DateTime, nullable=False)


class TicketsBookedByConductor(db.Model):
    __tablename__ = 'TicketsBookedByConductor'
    id = db.Column(db.String(32), primary_key=True)
    conductor_id = db.Column(db.String(32), ForeignKey('Conductor.id'))
    number_of_tickets = db.Column(db.Integer, nullable=False)
    phone_number = db.Column(db.String(10), nullable=False)
    amount_payed = db.Column(db.Integer, nullable=False)
    bus_no_id = db.Column(db.String(32), nullable=False)
    starting_bus_id = db.Column(db.String(32), nullable=False)
    end_bus_id = db.Column(db.String(32), nullable=False)
    booked_date_time = db.Column(db.DateTime, nullable=False)
    status = db.Column(db.Integer, nullable=False)

