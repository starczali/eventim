package events.dao.impl;

import events.dao.EventDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@ContextConfiguration(locations = "classpath:spring-test-config.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class EventDAOImplTest {

    @Autowired
    private EventDAO eventDAO;


    @Test
    public void getNextEventsForArtist() throws Exception {
        assertEquals(1,eventDAO.getNextEventsForArtist(2).size());
    }

}