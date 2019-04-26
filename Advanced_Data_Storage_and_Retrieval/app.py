
from flask import Flask, jsonify
import numpy as np
import pandas as pd
import datetime as dt
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

engine = create_engine("sqlite://Resources/hawaii.sqlite")
session = Session(bind=engine)

Base = automap_base()

Base.prepare(engine, reflect=True)

Base.classes.keys()

Measurement = Base.classes.measurement
Station = Base.classes.station



app = Flask(__name__)


@app.route("/")
def home_page():
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    
    p = session.query(Station.name, Measurement.date, Measurement.prcp).order_by(Measurement.date.desc()).all()
    return jsonify(p)

@app.route("/api/v1.0/stations")
def stations():
    s = session.query(Station.name).all()
    return jsonify(s)

@app.route("/api/v1.0/tobs")
def tobs():
    def temp():
        tobs = session.query(Station.name, Measurement.date, Measurement.tobs).order_by(Measurement.date.desc()).all()
        tobs_year = tobs[1:2250]
        return jsonify(tobs_year)
